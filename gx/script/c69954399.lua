--疫病ウィルス ブラックダスト
--Ekibyo Drakmord
function c69954399.initial_effect(c)
	aux.AddEquipProcedure(c,nil,nil,nil,nil,nil,c69954399.eqpop1,nil)
	--Cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	c:RegisterEffect(e2)
	--Count turns
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c69954399.turncon)
	e3:SetOperation(c69954399.turnop)
	c:RegisterEffect(e3)
	--Destroy monster
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc69954399(c69954399,0))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c69954399.descon)
	e4:SetTarget(c69954399.destg)
	e4:SetOperation(c69954399.desop)
	c:RegisterEffect(e4)
	--return itself to the hand
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringc69954399(c69954399,1))
	e5:SetCategory(CATEGORY_TOHAND)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_CUSTOM+c69954399+1)
	e5:SetTarget(c69954399.rettg)
	e5:SetOperation(c69954399.retop)
	c:RegisterEffect(e5)
end
function c69954399.eqpop1(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():SetTurnCounter(0)
end
function c69954399.turncon(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	return ec:GetControler()==Duel.GetTurnPlayer()
end
function c69954399.turnop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	c:SetTurnCounter(ct+1)
	c:RegisterFlagEffect(c69954399,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,0)
end
function c69954399.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetTurnCounter()==2 and e:GetHandler():GetFlagEffect(c69954399)>0
end
function c69954399.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ec=e:GetHandler():GetEquipTarget()
	ec:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,ec,1,0,0)
end
function c69954399.desop(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	if ec and ec:IsRelateToEffect(e) and Duel.Destroy(ec,REASON_EFFECT)~=0 then
		Duel.RaiseSingleEvent(e:GetHandler(),EVENT_CUSTOM+c69954399+1,e,0,0,0,0)
	end
end
function c69954399.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c69954399.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,e:GetHandler())
	end
end