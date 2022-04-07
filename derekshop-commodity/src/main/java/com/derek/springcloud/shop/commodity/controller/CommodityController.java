package com.derek.springcloud.shop.commodity.controller;


import com.derek.springcloud.shop.commodity.entities.Commodity;
import com.derek.springcloud.shop.commodity.service.CommodityService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Slf4j
@RestController
@RequestMapping(value = "/commodities", produces = MediaType.APPLICATION_JSON_VALUE)
public class CommodityController {

    @Autowired
    private CommodityService commodityService;

    // 取得一個產品
    @GetMapping("/{id}")
    public Commodity getCommodity(@PathVariable("id") UUID id) {
        return commodityService.find(id);
    }

    // 取得全部產品
    @GetMapping()
    public List<Commodity> getCommodities() {
        return commodityService.getAll();
    }

    // 新增產品
    @PostMapping()
    public Commodity createProduct(@RequestBody Commodity commodity) {
        return commodityService.save(commodity);
    }


    // 刪除一個產品
    @DeleteMapping("/{id}")

    // 對一個購物車做結帳
    @PostMapping("/carts/{id}/checkout")

    // 編輯一個產品
    @PutMapping("/{id}")
    public Commodity replaceCommodity(
            @PathVariable("id") UUID id, @RequestBody Commodity commodity) {
        return commodityService.save(commodity);
    }
}
