--レスキューキャット
--Rescue Cat
function c14878871.initial_effect(c)
	--Special Summon 2 Level 3 or lower Beast monsters from your Deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc14878871(c14878871,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,c14878871)
	e1:SetCost(c14878871.spcost)
	e1:SetTarget(c14878871.sptg)
	e1:SetOperation(c14878871.spop)
	c:RegisterEffect(e1)
end
function c14878871.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() end
	Duel.SendtoGrave(c,REASON_COST)
end
function c14878871.spfilter(c,e,tp)
	return c:IsLevelBelow(3) and c:IsRace(RACE_BEAST) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c14878871.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMZoneCount(tp,e:GetHandler())>1 and not Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT)
		and Duel.IsExistingMatchingCard(c14878871.spfilter,tp,LOCATION_DECK,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c14878871.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 or Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c14878871.spfilter,tp,LOCATION_DECK,0,2,2,nil,e,tp)
	if #sg~=2 then return end
	local c=e:GetHandler()
	local fc14878871=c:GetFieldID()
	for tc in sg:Iter() do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		tc:RegisterFlagEffect(c14878871,RESET_EVENT+RESETS_STANDARD,0,1,fc14878871)
		--Negate its effects
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
	end
	Duel.SpecialSummonComplete()
	sg:KeepAlive()
	--Destroy them during the End Phase
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	e3:SetLabel(fc14878871)
	e3:SetLabelObject(sg)
	e3:SetCondition(c14878871.descon)
	e3:SetOperation(c14878871.desop)
	Duel.RegisterEffect(e3,tp)
end
function c14878871.desfilter(c,fc14878871)
	return c:GetFlagEffectLabel(c14878871)==fc14878871
end
function c14878871.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c14878871.desfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c14878871.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c14878871.desfilter,nil,e:GetLabel())
	Duel.Destroy(tg,REASON_EFFECT)
end