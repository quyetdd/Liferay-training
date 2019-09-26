package account.setting.taglib.filter.portlet;


import java.io.IOException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.filter.FilterChain;
import javax.portlet.filter.FilterConfig;
import javax.portlet.filter.PortletFilter;
import javax.portlet.filter.RenderFilter;
import javax.portlet.filter.RenderResponseWrapper;

import org.osgi.service.component.annotations.Component;

import com.liferay.portal.kernel.util.PortletKeys;

/**
 * @author TTM
 */
@Component(
	immediate = true,
	property = {
			"javax.portlet.name=" + PortletKeys.MY_ACCOUNT
	},
	service = PortletFilter.class
)
public class AccountSettingTaglibFilterPortlet implements RenderFilter {

	@Override
	public void init(FilterConfig config) throws PortletException {

	}

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(RenderRequest request, RenderResponse response, FilterChain chain)
			throws IOException, PortletException {
		
		RenderResponseWrapper renderResponseWrapper = new BufferedRenderResponseWrapper(response);

		chain.doFilter(request, renderResponseWrapper);

		String text = renderResponseWrapper.toString();
		
		if (text != null) {		
			String nav = scrape_between(text,"<ul class=\"nav nav-underline\">","</ul>");
			
			ArrayList<String>  nav_header =  scrape_betweens(nav,"<li class=\"nav-item\">","</li>");
			if(nav_header.size()>0) {
			 nav_header.remove(0);
			 for(int i=0;i<nav_header.size();i++) {
				 text = text.replace(nav_header.get(i), "");
			 }
			}			
			String left = scrape_between(text,"<ul class=\"nav nav-nested\">","</ul>");
			
			ArrayList<String>  left_header =  scrape_betweens(left,"<li class=\"nav-item\">","</li>");
			int num_left = left_header.size();
			if(num_left>0) {
				left_header.remove(0);
				left_header.remove(num_left-2);
			 for(int i=0;i<left_header.size();i++) {
				 text = text.replace(left_header.get(i), "");
			 }
			}			
			response.getWriter().write(text);			
		}
	}
	
	private String scrape_between(String data,String start,String end) {
		 String a = strStr(data,start); // Stripping all data from before $start		
		 String b = a.substring(start.length());  // Stripping $start		
		 int stop = b.indexOf(end);   // Getting the position of the $end of the data to scrape		 
		 String result = b.substring(0, stop);
		 return result;		
	}
	
	private ArrayList<String>  scrape_betweens(String string, String start, String end)
	{
		Pattern pattern = Pattern.compile(start+"(.+?)"+end, Pattern.DOTALL);
		 ArrayList<String> list = new ArrayList<String>();
		 Matcher m = pattern.matcher(string);
		 while (m.find()) {
		     list.add(m.group());
		 }
		return list;
	}
	private String strStr(String haystack, String needle) {
	      if(haystack==null || needle==null) return null; 
	      int hLength=haystack.length(); 
	      int nLength=needle.length(); 
	      if(hLength<nLength) return null; 
	      if(nLength==0) return haystack;
	      for(int i=0; i<=hLength-nLength; i++)
	      {
	        if(haystack.charAt(i)==needle.charAt(0))
	        {
	          int j=0; 
	          for(; j<nLength; j++)
	          {
	            if(haystack.charAt(i+j)!=needle.charAt(j))
	            {
	              break; 
	            }
	          }
	          if(j==nLength) return haystack.substring(i) ; 
	        }  
	      }
	      return null; 
	    }
}
