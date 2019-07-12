import pandas as pd
import pandas as np
import cv2

def pd_load_csv(path):
  df = pd.read_csv(path)
  return df
  
def pd_head(df):
  return df.head(3)
