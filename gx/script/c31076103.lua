--第一の棺
--The First Sarcophagus
function c31076103.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Place "The Second Sarcophagus" or "The Third Sarcophagus" in your Spell/Trap Zone
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc31076103(c31076103,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(function(e,tp) return Duel.IsTurnPlayer(1-tp) and e:GetHandler():GetFlagEffect(c31076103)<2 end)
	e2:SetTarget(c31076103.pltg)
	e2:SetOperation(c31076103.plop)
	c:RegisterEffect(e2)
	--Send them to the GY if any leave the field
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c31076103.tgcon)
	e3:SetOperation(c31076103.tgop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetOperation(c31076103.tgop)
	c:RegisterEffect(e4)
end
c31076103.listed_names={4081094,78697395,c31076103,25343280}
function c31076103.pltg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetPossibleOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND|LOCATION_DECK)
end
function c31076103.plfilter(c,code)
	return c:IsCode(code) and not c:IsForbc31076103den()
end
function c31076103.spfilter(c,e,tp)
	return c:IsCode(25343280) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c31076103.plop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local c=e:GetHandler()
	local code=not c:HasFlagEffect(c31076103) and 4081094 or 78697395
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local pc=Duel.SelectMatchingCard(tp,c31076103.plfilter,tp,LOCATION_DECK|LOCATION_HAND,0,1,1,nil,code):GetFirst()
	if not (pc and Duel.MoveToField(pc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)) then return end
	c:RegisterFlagEffect(c31076103,RESET_EVENT|RESETS_STANDARD,0,0)
	if Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,c31076103),tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,4081094),tp,LOCATION_ONFIELD,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,78697395),tp,LOCATION_ONFIELD,0,1,nil) then
		local g=Duel.GetMatchingGroup(aux.FaceupFilter(Card.IsCode,c31076103,4081094,78697395),tp,LOCATION_ONFIELD,0,nil)
		Duel.BreakEffect()
		if Duel.SendtoGrave(g,REASON_EFFECT)~=#g or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sc=Duel.SelectMatchingCard(tp,c31076103.spfilter,tp,LOCATION_HAND|LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
		if sc and Duel.SpecialSummon(sc,0,tp,tp,true,false,POS_FACEUP)>0 then
			sc:CompleteProcedure()
		end
	end
end
function c31076103.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(aux.FaceupFilter(Card.IsCode,4081094,78697395),1,nil)
end
function c31076103.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.FaceupFilter(Card.IsCode,4081094,78697395),tp,LOCATION_ONFIELD,0,nil):Merge(e:GetHandler())
	Duel.SendtoGrave(g,REASON_EFFECT)
end