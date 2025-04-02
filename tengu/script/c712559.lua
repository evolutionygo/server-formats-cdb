--アマゾネスの里
--Amazoness Village
function c712559.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Increase ATK
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x4))
	e2:SetValue(200)
	c:RegisterEffect(e2)
	--Special Summon 1 "Amazoness" from your Deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc712559(c712559,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1)
	e3:SetCondition(c712559.spcon)
	e3:SetTarget(c712559.sptg)
	e3:SetOperation(c712559.spop)
	c:RegisterEffect(e3)
end
c712559.listed_series={0x4}
function c712559.cfilter(c,e,tp)
	return c:IsSetCard(0x4) and c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:HasLevel()
		and Duel.IsExistingMatchingCard(c712559.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp,c:GetLevel())
end
function c712559.spfilter(c,e,tp,lv)
	return c:IsLevelBelow(lv) and c:IsSetCard(0x4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c712559.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c712559.cfilter,1,nil,e,tp)
end
function c712559.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c712559.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local dg=eg:Filter(c712559.cfilter,nil,e,tp):Match(Card.IsRelateToEffect,nil,e)
	if #dg==0 then return end
	local _,lv=dg:GetMaxGroup(Card.GetOriginalLevel)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c712559.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,lv)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end