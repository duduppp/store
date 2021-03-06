package com.fh.controller.website.graphic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

 










import net.sf.json.JSONArray;

import org.apache.shiro.session.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.homepage.HomePage;
import com.fh.entity.system.Dictionaries;
import com.fh.service.system.dictionaries.DictionariesManager;
import com.fh.service.website.graphic.GraphicManager;
import com.fh.service.website.homepage.HomePageManager;
import com.fh.service.website.messages.MessagesManager;
import com.fh.service.website.statistics.StatisticsManager;
import com.fh.service.website.storeinfo.StoreInfoManager;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;
import com.fh.util.Tools;

@Controller
public class NewsContentController extends BaseController {
	@Resource(name = "graphicService")
	private GraphicManager graphicService;

	@Resource(name = "dictionariesService")
	private DictionariesManager dictionariesService;

	@Resource(name = "statisticsService")
	private StatisticsManager statisticsService;

	@Resource(name = "messagesService")
	private MessagesManager messagesService;
	
	@Resource(name="storeinfoService")
	private StoreInfoManager storeinfoService; 
	
	@Resource(name = "homepageService")
	private HomePageManager homepageService;

	@RequestMapping(value = "/getshowMenuData")
	@ResponseBody
	public Map<String, List<?>> getshowMenuData() throws Exception{
		
		List<Dictionaries> dataList=dictionariesService.listAllDict("0");
		PageData pd = new PageData();
		List<HomePage> homePages=	 homepageService.listHomePage(pd);
		Map<String, List<?>> dataMap=new HashMap<String, List<?>>();
		dataMap.put("dictionList", dataList);
		dataMap.put("homepgeList", homePages);
		String GRAPHIC_ID = pd.getString("GRAPHIC_ID");
	 
		PageData graphicPD= new PageData();
	 
		
		graphicPD.put("CATALOG_NAME", "关于远元");
		graphicPD.put("SUBDIRECTORY_NAME", "集团简介");
		graphicPD.put("SUNCATALOGUE_NAME", ""); 		
		List<PageData> aboutList = graphicService.listAll(graphicPD);
		dataMap.put("aboutList", aboutList);
		
		return dataMap;
		
		
	}
	/**
	 * 展示新闻的具体信息
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/newsData")
	public ModelAndView newsData(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		// 转码
		String CATALOG_NAME = java.net.URLDecoder.decode(
				pd.getString("CATALOG_NAME"), "UTF-8");
		String SUBDIRECTORY_NAME = java.net.URLDecoder.decode(
				pd.getString("SUBDIRECTORY_NAME"), "UTF-8");
		String SUNCATALOGUE_NAME = java.net.URLDecoder.decode(
				pd.getString("SUNCATALOGUE_NAME"), "UTF-8");

		putDictData(pd, CATALOG_NAME, SUBDIRECTORY_NAME, SUNCATALOGUE_NAME);
		// 查询数据
		page.setPd(pd);
		List<PageData> varList = graphicService.list(page);

		PageData paData = new PageData();
		List<PageData> cuntlist = graphicService.listAll(page);
		if (null != varList && cuntlist.size() >1) {

			for (PageData pageData : varList) {
				pageData.put("CONTENT", "");
			}

			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			JSONArray arr = JSONArray.fromObject(varList);
			mv.addObject("yyNews", arr.toString());
			mv.setViewName("../../website/newsList");
		} else {
			// 单数句 单页面
			if (null != varList && varList.size() == 1) {
				paData = varList.get(0);
				mv.addObject("yyNews", paData);
			}
			if (SUBDIRECTORY_NAME.equalsIgnoreCase("客户留言")) {
				mv.setViewName("../../website/message");
			} else {
				mv.setViewName("../../website/aboutYY");  
			}

		}

		PageData dictpd = new PageData();
		PageData dictdata = new PageData();
		dictpd = getSubDictData(CATALOG_NAME, dictdata);

		putMV(mv, SUBDIRECTORY_NAME, SUNCATALOGUE_NAME, dictpd, dictdata);

		// 点击量的统计
		PageData statisticsData = new PageData();

		statisticsData.put("STATISTICS_ID", this.get32UUID()); // 主键
		statisticsData.put("TYPE_PARENT_NAME", CATALOG_NAME);
		statisticsData.put("TYPE_SUB_NAME", SUBDIRECTORY_NAME);
		statisticsData.put("TYPE_SUN_NAME", SUNCATALOGUE_NAME);
		statisticsData.put("END_TIME", DateUtil.getCurrentDateTime());
		statisticsData.put("BROWSE_NUM", 1);

		statisticsService.save(statisticsData);

		return mv;

	}

	/**
	 * 通过主键请求新闻信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/newsShow")
	public ModelAndView newsShow() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String GRAPHIC_ID = pd.getString("GRAPHIC_ID");
		pd.put("GRAPHIC_ID", GRAPHIC_ID);
		PageData resultPageData = graphicService.findById(pd);
		mv.addObject("yyNews", resultPageData);
		mv.setViewName("../../website/aboutYY");

		String CATALOG_NAME = resultPageData.getString("CATALOG_NAME");
		String SUBDIRECTORY_NAME = resultPageData
				.getString("SUBDIRECTORY_NAME");
		String SUNCATALOGUE_NAME = resultPageData
				.getString("SUNCATALOGUE_NAME");

		putDictData(pd, CATALOG_NAME, SUBDIRECTORY_NAME, SUNCATALOGUE_NAME);
		PageData dictpd = new PageData();
		PageData dictdata = new PageData();
		dictpd = getSubDictData(CATALOG_NAME, dictdata);

		putMV(mv, SUBDIRECTORY_NAME, SUNCATALOGUE_NAME, dictpd, dictdata);

		return mv;

	}

	private void putDictData(PageData pd, String CATALOG_NAME,
			String SUBDIRECTORY_NAME, String SUNCATALOGUE_NAME) {
		pd.put("CATALOG_NAME", CATALOG_NAME);
		pd.put("SUBDIRECTORY_NAME", SUBDIRECTORY_NAME);
		pd.put("SUNCATALOGUE_NAME", SUNCATALOGUE_NAME);
	}

	private PageData getSubDictData(String CATALOG_NAME, PageData dictdata)
			throws Exception {
		PageData dictpd;
		dictdata.put("NAME", CATALOG_NAME);
		dictdata.put("parentId", "0");
		dictpd = dictionariesService.listSubDictByName(dictdata);
		return dictpd;
	}

	private void putMV(ModelAndView mv, String SUBDIRECTORY_NAME,
			String SUNCATALOGUE_NAME, PageData dictpd, PageData dictdata)
			throws Exception {
		if (null != dictpd) {
			String DICTIONARIES_ID = dictpd.getString("DICTIONARIES_ID");
			dictdata.put("parentId", DICTIONARIES_ID);
			if (null != SUNCATALOGUE_NAME && SUNCATALOGUE_NAME.length() > 0) {
				dictdata.put("NAME", SUBDIRECTORY_NAME);
				dictpd = dictionariesService.listSubDictByName(dictdata);
				DICTIONARIES_ID = dictpd.getString("DICTIONARIES_ID");

			}
			String NAME_EN = dictpd.getString("NAME_EN");
			List<Dictionaries> dicList = dictionariesService
					.listSubDictByParentId(DICTIONARIES_ID);

			JSONArray arr = JSONArray.fromObject(dicList);
			mv.addObject("NavigatList", arr.toString());
			mv.addObject("NAME_EN", NAME_EN);
		}
	}
	@RequestMapping(value = "/goNews")
	@ResponseBody
	public String goNews(String CATALOG_NAME, String SUBDIRECTORY_NAME,
			String SUNCATALOGUE_NAME) throws Exception {

		PageData pd = new PageData();
		putDictData(pd, CATALOG_NAME, SUBDIRECTORY_NAME, SUNCATALOGUE_NAME);

		List<PageData> varList = graphicService.findByTypes(pd);
		String json = "";
		if (null != varList) {
			JSONArray arr = JSONArray.fromObject(varList);
			json = arr.toString();
		}
		return json;

	}

	/**
	 * 
	 * @return 保存留言信息
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveMsg")
	@ResponseBody
	public String saveMsg() throws Exception {

		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Session session = Jurisdiction.getSession();  
		String sessionCode = (String) session
				.getAttribute(Const.SESSION_SECURITY_CODE); // 获取session中的验证码
		String verification_code=pd.getString("verification_code");
		String jsonString="";
		Map<String, String> map = new HashMap<String, String>();
		if (Tools.notEmpty(sessionCode)
				&& sessionCode.equalsIgnoreCase(verification_code)) { // 判断登录验证码
			
			session.removeAttribute(Const.SESSION_SECURITY_CODE);
			pd.put("MESSAGES_ID", this.get32UUID()); // 主键
			messagesService.save(pd);
			map.put("msg", "提交成功！");
			map.put("status", "true");
			jsonString= JSON.toJSONString(map);
			
		}else{
		 
			map.put("msg", "验证码错误！");
			map.put("status", "false");
			jsonString = JSON.toJSONString(map);  
		}
		return jsonString;
	}
	
	
	
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/storelist")
	@ResponseBody
	public String list(Page page) throws Exception{
		
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd); 
		
		List<PageData>	varList = storeinfoService.list(page);	//列出StoreInfo列表
		String json = "";
		if (null != varList) {
			JSONArray arr = JSONArray.fromObject(varList);
			json = arr.toString(); 
		}
		System.out.println(json);
		return json;
		 
	}
}
