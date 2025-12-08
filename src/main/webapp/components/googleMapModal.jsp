<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="modal fade" id="mapModal" tabindex="-1" aria-labelledby="mapModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl modal-dialog-centered">
    		<div class="modal-content">
    		
	        <div class="modal-header">
	            <h5 class="modal-title" id="mapModalLabel"><i class="bi bi-geo-alt-fill text-danger"></i> 이동 경로 확인</h5>
	            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	        </div>
	        
	        <div class="modal-body">
	            <div class="control-panel d-flex align-items-center justify-content-end mb-2">
	                <div class="d-flex align-items-center">
	                    <label for="choose-travel-mode" class="form-label me-2 m-0 small fw-bold">이동 수단:</label>
	                    <%-- 이동 수단 선택 드롭다운 --%>
	                    <select id="choose-travel-mode" class="form-select form-select-sm" style="width: 120px;">
	                        <option value="" disabled selected>선택</option>
	                        <option value="DRIVING">자동차</option>
	                        <option value="WALKING">도보</option>
	                        <option value="BICYCLING">자전거</option>
	                    </select>
	                </div>
	            </div>
	            <div id="map"></div>
	            <%-- 지도가 표시될 영역 --%>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	    		</div>
        </div>
    </div>
</div>