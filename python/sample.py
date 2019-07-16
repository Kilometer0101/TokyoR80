import pandas as pd

def pd_load_csv(path):
  df = pd.read_csv(path)
  return df
  
def pd_head3(df):
  return df.head(3)

def pd_head(df, n = 3):
  return df.head(n)
  

  
