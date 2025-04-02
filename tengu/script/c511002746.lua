--高等紋章術 (Anime)
--Advanced Heraldry Art (Anime)
function c511002746.initial_effect(c)
	--Xyz Summon using "Heraldic Beast" monsters in your GY
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511002746(c511002746,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002746.target)
	e1:SetOperation(c511002746.activate)
	c:RegisterEffect(e1)
end
c511002746.listed_series={SET_HERALDIC_BEAST}
function c511002746.xyzfilter(c,tp,mg)
	return c:IsXyzSummonable(nil,mg) and Duel.GetLocationCountFromEx(tp,tp,mg,c)>0
end
function c511002746.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_GRAVE,0,nil,SET_HERALDIC_BEAST)
	if chk==0 then return #mg>0 and Duel.IsExistingMatchingCard(c511002746.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,tp,mg) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511002746.activate(e,tp,eg,ep,ev,re,r,rp)
	local mg=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_GRAVE,0,nil,SET_HERALDIC_BEAST)
	local xyzg=Duel.GetMatchingGroup(c511002746.xyzfilter,tp,LOCATION_EXTRA,0,nil,tp,mg)
	if #xyzg>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
		Duel.XyzSummon(tp,xyz,nil,mg,99,99)
	end
end