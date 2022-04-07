//package com.derek.springcloud.shop.config;
//
//public class DatabaseEnvironmentRepository implements EnvironmentRepository {
//    @Override
//    public Environment findOne(String application, String profile, String label)
//    {
//        Environment environment = new Environment(application, profile);
//
//        final Map<String, String> properties = loadYouProperties();
//        environment.add(new PropertySource("mapPropertySource", properties));
//        return environment;
//    }
//}