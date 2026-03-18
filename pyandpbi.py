import pandas as pd
import matplotlib.pyplot as plt
 
# dataset is in Power BI
df = dataset
 
counts = df['ocean_proximity'].value_counts()
 
plt.figure(figsize=(6,4))
counts.plot(kind='bar', color='skyblue')
 
plt.title('Number of Homes by Ocean Proximity')
plt.xlabel('Ocean Proximity')
plt.ylabel('Count')
plt.xticks(rotation=45)
plt.tight_layout()
 
plt.show()
 
#population vs households

plt.figure(figsize=(6,4))
sns.scatterplot(data=df, x='population', y='households', alpha=0.5)
plt.title('Population vs Households')
plt.xlabel('Population')
plt.ylabel('Households')
plt.tight_layout()
plt.show()

#total rooms vs bedrooms
 
plt.figure(figsize=(6,4))
sns.scatterplot(data=df, x='total_rooms', y='total_bedrooms', alpha=0.5, color='green')
plt.title('Total Rooms vs Total Bedrooms')
plt.xlabel('Total Rooms')
plt.ylabel('Total Bedrooms')
plt.tight_layout()
plt.show()
 