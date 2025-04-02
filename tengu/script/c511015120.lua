--ジャンク・アンカー (Manga)
--Junk Anchor (Manga)
function c511015120.initial_effect(c)
	--Synchro Summon using this card and 1 "Junk" monster in your GY
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511015120.syncost)
	e1:SetTarget(c511015120.syntg)
	e1:SetOperation(c511015120.synop)
	c:RegisterEffect(e1)
end
c511015120.listed_series={SET_JUNK}
function c511015120.syncost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST)
end
function c511015120.matfilter(c,e,tp,mc)
	local mg=Group.FromCards(c,mc)
	return c:IsSetCard(SET_JUNK) and not c:IsType(TYPE_TUNER) 
		and Duel.IsExistingMatchingCard(c511015120.synfilter,tp,LOCATION_EXTRA,0,1,nil,mg)
end
function c511015120.synfilter(c,mg)
	return c:IsSynchroSummonable(nil,mg)
end
function c511015120.syntg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511015120.matfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511015120.synop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SMATERIAL)
	local tc=Duel.SelectMatchingCard(tp,c511015120.matfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,e:GetHandler()):GetFirst()
	local mg=Group.FromCards(tc,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sc=Duel.SelectMatchingCard(tp,c511015120.synfilter,tp,LOCATION_EXTRA,0,1,1,nil,mg):GetFirst()
	if sc then Duel.SynchroSummon(tp,sc,nil,mg) end
end