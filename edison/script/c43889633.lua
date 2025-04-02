--忘却の海底神殿
--Forgotten Temple of the Deep
function c43889633.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--This card's name becomes "Umi"
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetValue(CARD_UMI)
	c:RegisterEffect(e1)
	--Banish 1 Level 4 or lower Fish, Sea Serpent, or Aqua monster you control
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc43889633(c43889633,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetHintTiming(TIMING_END_PHASE,TIMINGS_CHECK_MONSTER_E)
	e2:SetTarget(c43889633.rmtg)
	e2:SetOperation(c43889633.rmop)
	c:RegisterEffect(e2)
end
c43889633.listed_names={CARD_UMI}
function c43889633.rmfilter(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_FISH|RACE_SEASERPENT|RACE_AQUA) and c:IsFaceup() and c:IsAbleToRemove()
end
function c43889633.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c43889633.rmfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c43889633.rmfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c43889633.rmfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,tp,0)
end
function c43889633.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsControler(tp) and c43889633.rmfilter(tc) and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0
		and tc:IsLocation(LOCATION_REMOVED) then
		local c=e:GetHandler()
		local fc43889633=c:GetFieldID()
		tc:RegisterFlagEffect(c43889633,RESET_EVENT|RESETS_STANDARD,0,1,fc43889633)
		if Duel.IsExistingMatchingCard(function(c) return c:GetFlagEffectLabel(c43889633)==fc43889633 end,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,tc) then return end
		--Special Summon the monster(s) banished by this card's effect
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringc43889633(c43889633,1))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetRange(LOCATION_SZONE)
		e1:SetCountLimit(1)
		e1:SetCondition(c43889633.spcon)
		e1:SetTarget(c43889633.sptg)
		e1:SetOperation(c43889633.spop)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD)
		c:RegisterEffect(e1)
	end
end
function c43889633.spcon(e,tp,eg,ep,ev,re,r,rp)
	local fc43889633=e:GetHandler():GetFieldID()
	return Duel.IsTurnPlayer(tp) and Duel.IsExistingMatchingCard(function(c) return c:GetFlagEffectLabel(c43889633)==fc43889633 end,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil)
end
function c43889633.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local fc43889633=e:GetHandler():GetFieldID()
	local g=Duel.GetMatchingGroup(function(c) return c:GetFlagEffectLabel(c43889633)==fc43889633 end,tp,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,#g,tp,0)
end
function c43889633.spop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetTargetCards(e)
	if #tg>0 then
		Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)
		local fc43889633=e:GetHandler():GetFieldID()
		if Duel.IsExistingMatchingCard(function(c) return c:GetFlagEffectLabel(c43889633)==fc43889633 end,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil) then return end
		e:Reset()
	end
end