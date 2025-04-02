--デュアル・ソルジャー
--Gemini Soldier
function c68366996.initial_effect(c)
	Gemini.AddProcedure(c)
	--Cannot be destroyed by battle once
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(Gemini.EffectStatusCondition)
	e1:SetValue(function(_,_,r) return (r&REASON_BATTLE)==REASON_BATTLE end)
	c:RegisterEffect(e1)
	--Special Summon 1 Level 4 or lower Gemini monster
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc68366996(c68366996,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(Gemini.EffectStatusCondition)
	e2:SetTarget(c68366996.target)
	e2:SetOperation(c68366996.operation)
	c:RegisterEffect(e2)
end
c68366996.listed_names={c68366996}
function c68366996.filter(c,e,tp)
	return not c:IsCode(c68366996) and c:IsLevelBelow(4) and c:IsType(TYPE_GEMINI) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c68366996.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c68366996.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c68366996.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c68366996.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end