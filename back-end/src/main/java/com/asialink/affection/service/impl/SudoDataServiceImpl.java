package com.asialink.affection.service.impl;

import com.asialink.affection.domain.ResponseResult;
import com.asialink.affection.domain.entity.SudoObj;
import com.asialink.affection.domain.vo.SudoVo;
import com.asialink.affection.utils.BeanCopyUtils;
import org.ektorp.CouchDbConnector;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class SudoDataServiceImpl implements SudoDataService {


    @Qualifier("CouchDbConnectorSudo")
    @Autowired
    CouchDbConnector couchDbConnectorSudo;

    @Override
    public ResponseResult getAllSudoData() {
        List<String> allDocIds = couchDbConnectorSudo.getAllDocIds();
        ArrayList<SudoObj> all = new ArrayList<>();
        for (String id : allDocIds) {
            SudoObj sudoObj = couchDbConnectorSudo.find(SudoObj.class, id);
            all.add(sudoObj);
        }
        List<SudoVo> sudoVoList = all.stream().map(sudoObj -> BeanCopyUtils.copyBean(sudoObj, SudoVo.class)).collect(Collectors.toList());
        return ResponseResult.okResult(sudoVoList);
    }
}
