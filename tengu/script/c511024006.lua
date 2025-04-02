--エクシーズ・シフト (Anime)
--Xyz Shift (Anime)
--Scripter by IanxWaifu
--fixed by MLD
function c511024006.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511024006.cost)
	e1:SetTarget(c511024006.target)
	e1:SetOperation(c511024006.activate)
	c:RegisterEffect(e1)
end
function c511024006.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511024006.cfilter(c,e,tp)
	return c:IsType(TYPE_XYZ) and c:IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(c511024006.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c:GetRank(),c)
end
function c511024006.spfilter(c,e,tp,rk,mc)
	return c:IsRank(rk) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c511024006.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return e:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsExistingMatchingCard(c511024006.cfilter,tp,LOCATION_MZONE,0,1,nil,e,tp)
	end
	e:SetLabel(0)
	local g=Duel.SelectMatchingCard(tp,c511024006.cfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetTargetParam(g:GetFirst():GetRank())
	Duel.SendtoGrave(g,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511024006.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sc=Duel.SelectMatchingCard(tp,c511024006.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)):GetFirst()
	if sc and Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local c=e:GetHandler()
		if c:IsRelateToEffect(e) then
			c:CancelToGrave()
			Duel.Overlay(sc,c)
		end
	end
end