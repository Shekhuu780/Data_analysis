import numpy as np
import pandas as pd


def analyze_sales_dataset(file_path):
  # 1. Load Dataset (Using the passed file_path argument)
  df = pd.read_csv("S:\collage\cleaned_sales_data.csv")
  print(f"Dataset Shape: {df.shape}\n")

  # 2. Basic Statistics (Count, Mean, Median, etc.)
  print("=" * 40)
  print("1. BASIC STATISTICS (Quantity, UnitPrice, TotalPrice)")
  print("=" * 40)
  numeric_cols = ["Quantity", "UnitPrice", "TotalPrice"]

  for col in numeric_cols:
    if col in df.columns:
      count = df[col].count()
      mean_val = df[col].mean()
      median_val = df[col].median()
      std_val = df[col].std()
      print(f"Metric: {col}")
      print(f"  - Count : {count}")
      print(f"  - Mean  : {mean_val:.2f}")
      print(f"  - Median: {median_val:.2f}")
      print(f"  - StdDev: {std_val:.2f}\n")

  # 3. Identify Outliers (Using IQR Method)
  print("=" * 40)
  print("2. OUTLIER IDENTIFICATION (IQR Method)")
  print("=" * 40)
  for col in ["UnitPrice", "TotalPrice"]:
    if col in df.columns:
      Q1 = df[col].quantile(0.25)
      Q3 = df[col].quantile(0.75)
      IQR = Q3 - Q1
      lower_bound = Q1 - 1.5 * IQR
      upper_bound = Q3 + 1.5 * IQR

      outliers = df[(df[col] < lower_bound) | (df[col] > upper_bound)]
      print(
          f"Column '{col}': Found {len(outliers)} potential outliers (Outside"
          f" range [{lower_bound:.2f}, {upper_bound:.2f}])"
      )

  # 4. Identify Trends & Patterns
  print("\n" + "=" * 40)
  print("3. TRENDS & PATTERNS")
  print("=" * 40)

  # Temporal Trend (Sales Over Time)
  if "Date" in df.columns:
    df["Date"] = pd.to_datetime(df["Date"], errors="coerce")
    df["YearMonth"] = df["Date"].dt.to_period("M")
    monthly_sales = (
        df.groupby("YearMonth")["TotalPrice"].agg(["sum", "count"]).reset_index()
    )
    monthly_sales.columns = ["YearMonth", "TotalRevenue", "OrderCount"]
    print("\nMonthly Sales Trend:")
    print(monthly_sales.to_string(index=False))

  # Product Performance Pattern
  if "Product" in df.columns and "TotalPrice" in df.columns:
    top_products = (
        df.groupby("Product")
        .agg(
            TotalRevenue=("TotalPrice", "sum"),
            UnitsSold=("Quantity", "sum"),
            Orders=("OrderID", "count"),
        )
        .sort_values(by="TotalRevenue", ascending=False)
    )
    print("\nTop 5 Products by Total Revenue:")
    print(top_products.head(5))

  # Referral Source Distribution
  if "ReferralSource" in df.columns:
    print("\nReferral Source Distribution:")
    print(df["ReferralSource"].value_counts(normalize=True) * 100)


# Run the analysis using the correct path
file_path = r"s:\collage\cleaned_sales_data.csv"
analyze_sales_dataset("S:\collage\csv")

