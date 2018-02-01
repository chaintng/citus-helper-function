CREATE OR REPLACE FUNCTION get_inactive_shard() RETURNS TABLE (
shardid bigint,
healthy_node_name text,
healthy_node_port integer,
inactive_node_name text,
inactive_node_port integer
) AS $$
BEGIN
RETURN QUERY SELECT DISTINCT ON (healthy_shard.shardid, inactive_shard.nodename, inactive_shard.nodeport)
healthy_shard.shardid, healthy_shard.nodename AS healthy_node_name, healthy_shard.nodeport AS healthy_node_port,
inactive_shard.nodename AS inactive_node_name, inactive_shard.nodeport AS inactive_node_port
FROM pg_dist_shard_placement AS healthy_shard
JOIN (SELECT pg_dist_shard_placement.shardid, pg_dist_shard_placement.nodename, pg_dist_shard_placement.nodeport FROM pg_dist_shard_placement WHERE shardstate = 3) inactive_shard ON inactive_shard.shardid = healthy_shard.shardid
AND shardstate = 1;
END;
$$ LANGUAGE PLPGSQL;
