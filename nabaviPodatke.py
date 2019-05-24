import numpy as np
import pandas as pd
import requests
from bs4 import BeautifulSoup

years = np.arange(2019,1947,-1)

url = 'https://www.basketball-reference.com/play-index/tsl_finder.cgi?request=1&match=single&type=team_totals&year_min={}&year_max={}&order_by=year_id'
seasons_stats = pd.DataFrame()

for year in years:
    req_url = url.format(year, year)
    req = requests.get(req_url)
    soup = BeautifulSoup(req.content, 'html.parser')
    table = soup.find('table', {'id':'stats'})
    df = pd.read_html(str(table))[0]
    df['Year'] = year
    
    seasons_stats = seasons_stats.append(df)

seasons_stats.to_csv('seasons.csv', sep=',', encoding='utf-8')