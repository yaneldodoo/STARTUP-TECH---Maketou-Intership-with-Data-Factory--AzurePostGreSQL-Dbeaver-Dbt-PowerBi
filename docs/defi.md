# Challenges Faced

# # Dirty Data

I faced many difficulties during the ingestion of the payment and cart tables. The data was very messy, with different separators.
I discovered the use of quotechar to protect commas inside values.

The ID field also needed to be cleaned because it contained a mix of letters and numbers, so I used replace to convert it into a numeric format.

# # Date Normalization

The dates were written in a human-readable format (e.g., “November”, etc.), so I had to first translate them into English to make them compatible with SQL processing.
They also contained hours and time zones, so I had to split and clean them step by step.

# # dbt Setup

dbt was only compatible with Python 3.11, so I had to completely rebuild my environment, install the correct Python version, and reinitialize the project.