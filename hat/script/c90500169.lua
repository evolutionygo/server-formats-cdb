--レベルダウン！？
--Level Down!?
function c90500169.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc90500169(c90500169,0))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_MAIN_END|TIMINGS_CHECK_MONSTER_E)
	e1:SetTarget(c90500169.target)
	e1:SetOperation(c90500169.activate)
	c:RegisterEffect(e1)
end
c90500169.listed_series={SET_LV}
function c90500169.tdfilter(c,e,tp)
	if not (c:IsSetCard(SET_LV) and c:IsFaceup() and c:IsAbleToDeck()) then return false end
	local owner=c:GetOwner()
	if Duel.GetMZoneCount(owner,c,tp)<=0 then return false end
	local class=c:GetMetatable(true)
	return class and clasc90500169.LVnum and clasc90500169.LVset
		and Duel.IsExistingMatchingCard(c90500169.spfilter,owner,LOCATION_GRAVE,0,1,nil,e,tp,owner,clasc90500169.LVnum,clasc90500169.LVset)
end
function c90500169.spfilter(c,e,tp,owner,lvnum,lvset)
	local class=c:GetMetatable(true)
	return class and clasc90500169.LVnum and clasc90500169.LVnum<lvnum and clasc90500169.LVset==lvset
		and c:IsCanBeSpecialSummoned(e,0,tp,true,false,POS_FACEUP,owner)
end
function c90500169.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c90500169.tdfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c90500169.tdfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local tc=Duel.SelectTarget(tp,c90500169.tdfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e,tp):GetFirst()
	Duel.SetOperationInfo(0,CATEGORY_TODECK,tc,1,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tc:GetOwner(),LOCATION_GRAVE)
end
function c90500169.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and tc:IsFaceup()) then return end
	local owner=tc:GetOwner()
	local class=tc:GetMetatable(true)
	if not (Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_DECK|LOCATION_EXTRA)
		and Duel.GetLocationCount(owner,LOCATION_MZONE)>0 and class and clasc90500169.LVnum and clasc90500169.LVset) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c90500169.spfilter,owner,LOCATION_GRAVE,0,1,1,nil,e,tp,owner,clasc90500169.LVnum,clasc90500169.LVset)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,owner,true,false,POS_FACEUP)
	end
end