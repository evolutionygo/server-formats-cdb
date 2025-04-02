--奇跡の残照
--Miracle's Wake
function c21636650.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER_E)
	e1:SetTarget(c21636650.sptg)
	e1:SetOperation(c21636650.spop)
	c:RegisterEffect(e1)
end
function c21636650.filter(c,e,tp,tc21636650)
	return c:GetTurnID()==tc21636650 and (c:GetReason()&REASON_BATTLE)~=0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c21636650.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc21636650=Duel.GetTurnCount()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c21636650.filter(chkc,e,tp,tc21636650) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c21636650.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp,tc21636650) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c21636650.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,tc21636650)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c21636650.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end