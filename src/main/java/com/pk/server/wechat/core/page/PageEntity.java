package com.pk.server.wechat.core.page;

public class PageEntity {
    private Integer startRow = 0;//当前页面开始行
    private Integer pageSize = 10;//每页显示多少条
    private Integer rowNum; //总共多少条
    private Integer pageNum = 1;//当前页

    public Integer getStartRow() {
        return startRow;
    }

    public void setStartRow(Integer startRow) {
        this.startRow = startRow;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getRowNum() {
        return rowNum;
    }

    public void setRowNum(Integer rowNum) {
        this.rowNum = rowNum;
    }

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

}
