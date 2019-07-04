import pandas as pd
import pandas as np

def pd_read_csv(path):
  return pd.read_csv(path)

def pd_head(df):
  return df.head(3)
