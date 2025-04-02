--儀水鏡の幻影術
--Aquamirror Illusion
function c64437633.initial_effect(c)
	--Special Summon 1 "Gishki" Ritual Monster from your hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc64437633(c64437633,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetTarget(c64437633.target)
	e1:SetOperation(c64437633.activate)
	c:RegisterEffect(e1)
end
c64437633.listed_series={0x3a}
function c64437633.spfilter(c,e,tp)
	return c:IsSetCard(0x3a) and c:IsRitualMonster() and c:IsCanBeSpecialSummoned(e,0,tp,false,true)
end
function c64437633.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c64437633.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c64437633.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sc=Duel.SelectMatchingCard(tp,c64437633.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp):GetFirst()
	if sc and Duel.SpecialSummon(sc,0,tp,tp,false,true,POS_FACEUP)>0 then
		local c=e:GetHandler()
		--Cannot attack
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringc64437633(c64437633,1))
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		sc:RegisterEffect(e1,true)
		--Return it to hand during end phase
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCountLimit(1)
		e2:SetOperation(function(e) Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT) end)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		sc:RegisterEffect(e2,true)
	end
end