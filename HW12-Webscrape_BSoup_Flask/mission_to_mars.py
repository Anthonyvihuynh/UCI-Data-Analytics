
# coding: utf-8

# In[39]:

def scrape():
	# Import dependencies
	from bs4 import BeautifulSoup as bs
	import requests
	import pandas as pd
	from splinter import Browser


	# In[21]:


	# NASA Mars News
	url = "https://mars.nasa.gov/news/"
	response = requests.get(url)


	# In[22]:


	soup = bs(response.text, 'html.parser')
	print(soup.prettify())


	# In[26]:


	news_title = soup.body.find_all(class_="content_title")[0].text
	news_p = soup.body.find_all(class_="rollover_description_inner")[0].text


	# In[29]:


	# JPL Mars Space Images - Featured Image
	executable_path = {'executable_path': 'chromedriver.exe'}
	browser = Browser('chrome', **executable_path, headless=False)


	# In[30]:


	url = 'https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars'
	browser.visit(url)


	# In[32]:


	featured_image_url = "https://www.jpl.nasa.gov/spaceimages/images/mediumsize/PIA19334_ip.jpg"


	# In[34]:


	# Mars Weather
	url = "https://twitter.com/marswxreport?lang=en"
	response = requests.get(url)


	# In[35]:


	soup = bs(response.text, 'html.parser')
	print(soup.prettify())


	# In[37]:


	mars_weather = soup.body.find_all(class_="TweetTextSize TweetTextSize--normal js-tweet-text tweet-text")[0].text
	mars_weather


	# In[40]:


	# Mars Facts
	url = "https://space-facts.com/mars/"
	tables = pd.read_html(url)
	tables


	# In[56]:


	marsdf = tables[0]
	marsdf.columns = ["Profile", "Info"]
	marsdf


	# In[57]:


	html_table = marsdf.to_html()
	html_table


	# In[60]:


	# Mars Hemispheres
	hemisphere_image_urls = []
	Valles = {"title": "Valles Marineris Hemisphere", "img_url": "https://astropedia.astrogeology.usgs.gov/download/Mars/Viking/valles_marineris_enhanced.tif/full.jpg"}
	Cerberus = {"title": "Cerberus Hemisphere", "img_url": "https://astropedia.astrogeology.usgs.gov/download/Mars/Viking/cerberus_enhanced.tif/full.jpg"}
	Schiaparelli = {"title": "Schiaparelli Hemisphere", "img_url": "https://astropedia.astrogeology.usgs.gov/download/Mars/Viking/schiaparelli_enhanced.tif/full.jpg"}
	Syrtis = {"title": "Syrtis Major Hemisphere", "img_url": "https://astropedia.astrogeology.usgs.gov/download/Mars/Viking/syrtis_major_enhanced.tif/full.jpg"}


	# In[61]:


	hemisphere_image_urls.append(Valles)
	hemisphere_image_urls.append(Cerberus)
	hemisphere_image_urls.append(Schiaparelli)
	hemisphere_image_urls.append(Syrtis)
	hemisphere_image_urls

	return (hemisphere_image_urls, news_p, news_title, mars_weather, featured_image_url)