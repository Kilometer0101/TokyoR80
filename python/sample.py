import pandas as pd
import pandas as np

def pd_load_csv(path):
  df = pd.read_csv(path)
  df = df.sort_values(by='y', ascending=False)
  df = df[df['z'] == 'a']
  return df
  
def pd_head(df):
  return df.head(3)
