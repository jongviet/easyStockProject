package com.easystock.persistence.comment;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.easystock.domain.CommentVO;

@Repository
public class CommentDAO implements CommentDAORule {
  private static Logger logger = LoggerFactory.getLogger(CommentDAO.class);
  private final String NS = "CommentMapper.";
  
  @Inject
  private SqlSession sql;
  
  @Override
  public int insert(CommentVO cvo) {
    return sql.insert(NS+"post", cvo);
  }
  
  @Override
  public List<CommentVO> selectList(String symbol) {
    return sql.selectList(NS+"c_list", symbol);
  }
  
  @Override
  public int update(int cNum, int num) {
    Map<String, Object> map = new HashMap<>();
    map.put("cNum", (Integer)cNum);
    map.put("num", (Integer)num);
    return sql.update(NS+"t_up", map);
  }
  
  @Override
  public int chkliked(int cNum, String writer) {
    Map<String, Object> map = new HashMap<>();
    map.put("cNum", (Integer)cNum);
    map.put("writer", (String)writer);
    return sql.selectOne(NS+"chkliked", map);
  }
  
  @Override
  public int onLiked(int cNum, String writer) {
    Map<String, Object> map = new HashMap<>();
    map.put("cNum", (Integer)cNum);
    map.put("writer", (String)writer);
    return sql.insert(NS+"onLiked", map);
  }
  
  @Override
  public int offLiked(int cNum, String writer) {
    Map<String, Object> map = new HashMap<>();
    map.put("cNum", (Integer)cNum);
    map.put("writer", (String)writer);
    return sql.delete(NS+"offLiked", map);
  }
}

