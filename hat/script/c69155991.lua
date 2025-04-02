--スクラップ・シャーク
--Scrap Shark
function c69155991.initial_effect(c)
	--Register the activation of a Spell, Trap, or monster effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c69155991.chop)
	c:RegisterEffect(e1)
	--Destroy this card after activation of Spell, Trap or monster effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c69155991.desop1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BATTLED)
	e3:SetRange(LOCATION_MZONE)
	e3:SetOperation(c69155991.desop2)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--Send 1 "Scrap" monster from Deck to GY
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc69155991(c69155991,0))
	e4:SetCategory(CATEGORY_TOGRAVE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCondition(c69155991.tgcon)
	e4:SetTarget(c69155991.tgtg)
	e4:SetOperation(c69155991.tgop)
	c:RegisterEffect(e4)
end
c69155991.listed_series={SET_SCRAP}
function c69155991.chop(e,tp,eg,ep,ev,re,r,rp)
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) or re:GetHandler():IsMonster() then
		e:GetHandler():RegisterFlagEffect(c69155991,RESET_EVENT|RESETS_STANDARD|RESET_CHAIN,0,1)
	end
end
function c69155991.desop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(c69155991)==0 then return end
	c:ResetFlagEffect(c69155991)
	local ph=Duel.GetCurrentPhase()
	if (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) and not Duel.IsDamageCalculated() then
		c:RegisterFlagEffect(c69155991+1,RESET_EVENT|RESETS_STANDARD|RESET_PHASE|PHASE_DAMAGE,0,1)
	else
		Duel.Destroy(c,REASON_EFFECT)
	end
end
function c69155991.desop2(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(c69155991+1)>0 then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
function c69155991.tgcon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT) and c:IsLocation(LOCATION_GRAVE) and re:GetHandler():IsSetCard(SET_SCRAP)
end
function c69155991.tgfilter(c)
	return c:IsSetCard(SET_SCRAP) and c:IsMonster() and c:IsAbleToGrave()
end
function c69155991.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c69155991.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c69155991.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c69155991.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end