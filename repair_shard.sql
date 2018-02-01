CREATE OR REPLACE FUNCTION repair_shard() RETURNS void AS $$
DECLARE
temprow RECORD;
BEGIN
FOR temprow IN
    SELECT * FROM get_inactive_shard()
LOOP
PERFORM master_copy_shard_placement(temprow.shardid, temprow.healthy_node_name, temprow.healthy_node_port, temprow.inactive_node_name, temprow.inactive_node_port);
END LOOP;
END;
$$ LANGUAGE plpgsql;
