package com.derek.springcloud.shop.commodity.service.impl;

import com.derek.springcloud.shop.commodity.repo.CommodityRepo;
import com.derek.springcloud.shop.commodity.service.CommodityService;
import com.derek.springcloud.shop.commodity.entities.Commodity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class CommodityServiceImpl implements CommodityService {

	@Autowired
	private CommodityRepo commodityRepo;

	@Override
	public Commodity save(Commodity com) {
		return commodityRepo.save(com);
	}

	@Override
	public Commodity find(UUID id) {
		return commodityRepo.getOne(id);
	}

	@Override
	public List<Commodity> getAll() {
		return commodityRepo.findAll();
	}

	@Override
	public Commodity delete(Commodity com) {
		return com;
	}
}
