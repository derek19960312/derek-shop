package com.derek.springcloud.derekshop.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.derek.springcloud.derekshop.service.WebCommodityService;
import com.derek.springcloud.shop.commodity.entities.Commodity;

@RestController
public class WebApplication {

	@Autowired
	WebCommodityService ws;
	
	@GetMapping("commodity/findAll")
	public List<Commodity> findAll() {
		return ws.getAll();
	}

	@GetMapping("commodity/findById/{id}")
	public Commodity findById(@PathVariable("id") String id) {
		return ws.getById(id);
	}
	
	@PostMapping("commodity/add")
	public Commodity findById(@RequestBody Commodity commodity) {
		return ws.add(commodity);
	}

}
