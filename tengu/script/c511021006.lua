--オネスト (Anime)
--Honest (Anime)
local s,c511021006,alias=GetID()
function c511021006.initial_effect(c)
	alias=c:GetOriginalCodeRule()
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511021006(alias,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511021006.thtg)
	e1:SetOperation(c511021006.thop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511021006(alias,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCost(c511021006.atkcost)
	e2:SetTarget(c511021006.atktg)
	e2:SetOperation(c511021006.atkop)
	c:RegisterEffect(e2)
end
function c511021006.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c511021006.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
function c511021006.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511021006.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(7) and c:IsRace(RACE_WARRIOR)
end
function c511021006.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511021006.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511021006.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511021006.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c511021006.atkop(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c511021006.adval)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetOwnerPlayer(tp)
		tc:RegisterEffect(e1)
	end
end
function c511021006.adval(e,c)
	local bc=e:GetHandler():GetBattleTarget()
	if not bc then return 0 end
	local tc=not bc:IsControler(e:GetOwnerPlayer()) and bc or e:GetHandler()
	return tc:GetAttack()
end