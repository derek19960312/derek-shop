package com.derek.springcloud.derekshop.service;

import java.util.List;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.derek.springcloud.shop.commodity.entities.Commodity;

@FeignClient("derekshop-commodity-com.derek.springcloud.shop.service")
public interface WebCommodityService {
	
	@GetMapping(value = "commodities")
    List<Commodity> getAll();

	@GetMapping(value = "commodities/{id}")
    Commodity getById(@PathVariable("id") String id);
	
	@PostMapping(value = "commodities")
    Commodity add(@RequestBody Commodity commodity);
}
