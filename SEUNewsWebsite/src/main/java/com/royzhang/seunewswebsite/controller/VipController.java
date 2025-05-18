package com.royzhang.seunewswebsite.controller;

import com.royzhang.seunewswebsite.entity.Vip;
import com.royzhang.seunewswebsite.service.VipService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/vips")
public class VipController {

    @Autowired
    private VipService vipService;

    @GetMapping
    public ResponseEntity<List<Vip>> getAllVips() {
        List<Vip> vips = vipService.findAll();
        return new ResponseEntity<>(vips, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Vip> getVipById(@PathVariable Integer id) {
        Optional<Vip> vip = vipService.findById(id);
        return vip.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping
    public Vip createVip(@RequestBody Vip vip) {
        return vipService.save(vip);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteVip(@PathVariable Integer id) {
        vipService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}