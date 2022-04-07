package com.derek.springcloud.shop.commodity.service;

import com.derek.springcloud.shop.commodity.entities.Commodity;

import java.util.List;
import java.util.UUID;

public interface CommodityService {

	
	public Commodity save(Commodity com);
	
	public Commodity find(UUID id);

	public List<Commodity> getAll();
	
	public Commodity delete(Commodity com);
}
