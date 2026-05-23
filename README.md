# Building an End-to-End Data Pipeline at Maketou

## About Maketou

[Maketou](https://maketou.com) is a fast-growing African tech startup helping content creators and entrepreneurs sell digital products online.

Often described internally as “the African Shopify”, the platform empowers thousands of creators across the continent to monetize their knowledge, services, and communities.

During my internship, I worked as an Analytics Engineer, building scalable data workflows and transforming raw business data into actionable insights.

### Maketou in numbers

More than $1M paid out to creators in only 5 months

More than 31,000 online stores created

Presence in more than 17 African countries

## My Mission

Before my arrival, a large amount of business data was scattered across Excel files:
- sales data, 
- payment data, 
- customer activity,
- and business metrics.

Although the company had valuable data, it was difficult to:
centralize information,
monitor KPIs,
analyze business performance,
identify payment issues,
and support decision-making.

The data existed, but no real analytics infrastructure was in place.

My mission was to transform these disconnected files into a modern and scalable analytics pipeline.

## What I Built

I designed and implemented an end-to-end modern data stack including:

Airbyte with Docker to the ingestion of CSV 

PostgreSQL on Azure for the tables

Dbeaver for the analytic data base and SQL requests

dbt for data transformation

Power BI for business intelligence dashboards

SQL-based analytics models

Staging, Intermediate, and Gold data layers

## Key Contributions

### Data Centralization

Migrated and structured raw Excel business data into a centralized PostgreSQL database hosted on Azure.

### Data Cleaning & Transformation

Built dbt models to:
clean inconsistent payment data,
standardize currencies and timestamps,
handle null values and failed transactions,
and create analytics-ready tables.

### KPI & Dashboard Creation

Designed Power BI dashboards to track:
revenue performance,
payment success vs failed transactions,
payment processor performance,
payment error analysis,
and transaction trends over time.

### Payment Failure Analysis

Implemented analytics models to identify:
the most common payment failure reasons,
failure frequency by processor,
transaction bottlenecks,
and payment conversion insights.

## What I Learned

This experience gave me hands-on exposure to:
modern data engineering workflows,
analytics engineering best practices,
cloud databases,
BI reporting,
and production-oriented SQL modeling.

More importantly, I learned how data can directly support strategic business decisions in a fast-growing startup environment.

## Tech Stack

Docker and Airbyte

Azure Database for PostgreSQL

dbt

Power BI

SQL

Git & GitHub