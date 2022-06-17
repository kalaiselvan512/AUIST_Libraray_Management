import pandas as pd
from catalog.models import Book

def create():
    df=pd.read_excel("Book2.xlsx")
    for x,y in df.iterrows():
        
            Book.objects.create(**y.to_dict())
            # print(x,y.to_dict())
            # break

        