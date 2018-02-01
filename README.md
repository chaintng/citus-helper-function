# Citus Helper Function

[Citus](https://github.com/citusdata/citus/) didn't come with some necessary function by default. I wrote some function to help maintenance jobs easier.

1. `get_inactive_shard()`: Query to show shard that become inactive.
2. `repair_shard()`: Query to repair ALL shard by replace the healthy shard to inactive shard.
3. `repair_single_shard(shard_id)`: Query to repair single shard (expect shard_id as a parameter).
