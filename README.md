# SQL-RewriteBench cases for Artemis

Single SQL queries from [SQL-RewriteBench](https://github.com/SQL-RewriteBench/benchmark) to make faster
without changing their results, one folder per case:

- `cases/<ID>/query.sql`: the query to rewrite. This is the only file a version should change.
- `cases/<ID>/original.sql`: the benchmark's input, kept for reference.

The queries run on PostgreSQL 16 over TPC-DS data at scale factor 10, with scale factor 1 as a second,
different database. A rewrite counts only if it returns the original's rows on both. The checker, the trusted
original and the data are not in this repository: they live in the test environment, so a version can't change them.

Cases: PERF-027.

See NOTICE for where the queries come from and their licence.
