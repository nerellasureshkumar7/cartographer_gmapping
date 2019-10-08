include 'map_builder.lua'
include 'trajectory_builder.lua'

options = {
    map_builder = MAP_BUILDER,
    trajectory_builder = TRAJECTORY_BUILDER,
    map_frame = 'map', --frame in which the map is published
    tracking_frame = 'imu_link', --frame which needs to be tracked
    published_frame = 'odom', -- frame in which odom is published by cartographer
    odom_frame = 'odom', -- frame in which the odom is being recieved by cartographer
    provide_odom_frame = false, -- true if cartographer to provide odometry
    publish_frame_projected_to_2d = true, --If enabled, the published pose will be restricted to a pure 2D pose
    use_odometry = true, -- true if you want to subscribe the cartographer for "odom"
    -- use_laser_scan = true,
    -- use_multi_echo_laser_scan = false,
    use_nav_sat = false, --true if you have a GPS
    use_landmarks = false,
    num_laser_scans = 1, -- number of laser scans to subscribe to
    num_multi_echo_laser_scans = 0,
    num_subdivisions_per_laser_scan = 1,
    num_point_clouds = 0,
    lookup_transform_timeout_sec = 0.2, --Timeout in seconds to use for looking u ptransforms using tf2.
    submap_publish_period_sec = 0.3, --Interval in seconds at which to publish the submap poses, e.g. 0.3 seconds.
    pose_publish_period_sec = 5e-3, --Interval in seconds at which to publish poses, e.g. 5e-3 for a frequency of 200 Hz. (map frequency)
    trajectory_publish_period_sec = 30e-3, --    Interval in seconds at which to publish the trajectory markers, e.g. 30e-3 for 30 milliseconds.
    rangefinder_sampling_ratio = 1., --Fixed ratio sampling for range finders messages.
    odometry_sampling_ratio = 1,
    fixed_frame_pose_sampling_ratio = 1, --Fixed ratio sampling for fixed frame messages.
    imu_sampling_ratio = 1.,
    landmarks_sampling_ratio = 1.
}
TRAJECTORY_BUILDER_2D.use_imu_data = true


MAP_BUILDER.use_trajectory_builder_2d = true
MAP_BUILDER.num_background_threads = 4

TRAJECTORY_BUILDER_2D.min_range = 0.05 --Increase 0.05
TRAJECTORY_BUILDER_2D.max_range = 8 -- Decrease
TRAJECTORY_BUILDER_2D.missing_data_ray_length = 5.

TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching = false
-- TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.linear_search_window = 0.05
-- TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.angular_search_window = math.rad(4.)

TRAJECTORY_BUILDER_2D.ceres_scan_matcher.translation_weight=100
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.rotation_weight=150

TRAJECTORY_BUILDER_2D.submaps.num_range_data = 100 --70   

POSE_GRAPH.optimize_every_n_nodes = 100 --70  


TRAJECTORY_BUILDER_2D.submaps.range_data_inserter.probability_grid_range_data_inserter.hit_probability = 0.57  --0.65
TRAJECTORY_BUILDER_2D.submaps.range_data_inserter.probability_grid_range_data_inserter.miss_probability = 0.45  --0.45

TRAJECTORY_BUILDER_2D.num_accumulated_range_data = 1

-- Increase
POSE_GRAPH.constraint_builder.min_score=0.7
POSE_GRAPH.optimization_problem.huber_scale=1
POSE_GRAPH.constraint_builder.sampling_ratio=0.3
POSE_GRAPH.global_sampling_ratio = 0.001
-- trajectory_builder_options_proto =0
-- POSE_GRAPH.constraint_builder.max_constraint_distance = 0.1

-- POSE_GRAPH.optimization_problem.local_slam_pose_translation_weight = 1e5
-- POSE_GRAPH.optimization_problem.local_slam_pose_rotation_weight = 1e4
-- POSE_GRAPH.optimization_problem.odometry_translation_weight = 1e5
-- POSE_GRAPH.optimization_problem.odometry_rotation_weight = 1e1

-- TRAJECTORY_BUILDER_2D.motion_filter.max_distance_meters = 0.05
-- TRAJECTORY_BUILDER_2D.motion_filter.max_angle_radians = math.rad(3)
-- TRAJECTORY_BUILDER_2D.motion_filter.max_time_seconds = 10
-- POSE_GRAPH.constraint_builder.loop_closure_translation_weight = 10
-- POSE_GRAPH.constraint_builder.loop_closure_rotation_weight = 1e3

return options
