--ゴーストリック・イエティ
--Ghostrick Yeti
function c84472026.initial_effect(c)
	--Cannot be normal summoned if player controls no "Ghostrick" monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c84472026.sumcon)
	c:RegisterEffect(e1)
	--Change itself to face-down defense position
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc84472026(c84472026,0))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c84472026.postg)
	e2:SetOperation(c84472026.posop)
	c:RegisterEffect(e2)
	--Targeted "Ghostrick" monster cannot be destroyed by battle or card effect
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc84472026(c84472026,1))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_FLIP)
	e3:SetTarget(c84472026.indestg)
	e3:SetOperation(c84472026.indesop)
	c:RegisterEffect(e3)
end
c84472026.listed_series={0x8d}
function c84472026.sfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x8d)
end
function c84472026.sumcon(e)
	return not Duel.IsExistingMatchingCard(c84472026.sfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c84472026.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(c84472026)==0 end
	c:RegisterFlagEffect(c84472026,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c84472026.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end
end
function c84472026.indestg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c84472026.sfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c84472026.sfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c84472026.sfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c84472026.indesop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		--Cannot be destroyed by battle or card effects
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(3008)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		tc:RegisterEffect(e2)
	end
end