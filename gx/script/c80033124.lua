--サイバーダーク・インパクト！
--Cyberdark Impact!
function c80033124.initial_effect(c)
	--Activate
	local e1=Fusion.CreateSummonEff(c,aux.FilterBoolFunction(Card.IsCode,40418351),Card.IsAbleToDeck,c80033124.fextra,Fusion.ShuffleMaterial,nil,nil,nil,nil,nil,nil,nil,nil,nil,c80033124.extratg)
	c:RegisterEffect(e1)
end
c80033124.listed_names={40418351,41230939,77625948,3019642}
function c80033124.matfilter(c,lc,stype,tp)
	return c:IsSummonCode(lc,stype,tp,41230939,77625948,3019642) and c:IsAbleToDeck()
end
function c80033124.frec(c,tp,sg,g,code,...)
	if not c:IsSummonCode(fc,SUMMON_TYPE_FUSION,tp,code) then return false end
	if ... then
		g:AddCard(c)
		local res=sg:IsExists(c80033124.frec,1,g,tp,sg,g,...)
		g:RemoveCard(c)
		return res
	else return true end
end
function c80033124.fcheck(tp,sg,fc,mg)
	return #sg==3 and sg:IsExists(c80033124.frec,1,nil,tp,sg,Group.CreateGroup(),41230939,77625948,3019642)
end
function c80033124.fextra(e,tp,mg)
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(Card.IsAbleToDeck),tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,nil)
	return g,c80033124.fcheck
end
function c80033124.extratg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,0,tp,LOCATION_HAND+LOCATION_ONFIELD+LOCATION_GRAVE)
end