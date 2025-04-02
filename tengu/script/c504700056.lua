--堕落
--Falling Down (GOAT)
--If monster is immuned, no damage occurs
function c504700056.initial_effect(c)
	aux.AddEquipProcedure(c,1,Card.IsControlerCanBeChanged,c504700056.eqlimit,nil,c504700056.target)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc504700056(c504700056,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c504700056.damcon)
	e2:SetTarget(c504700056.damtg)
	e2:SetOperation(c504700056.damop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c504700056.descon)
	c:RegisterEffect(e3)
	--control
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_SET_CONTROL)
	e5:SetValue(c504700056.ctval)
	c:RegisterEffect(e5)
end
c504700056.listed_series={0x45}
function c504700056.eqlimit(e,c)
	return e:GetHandlerPlayer()~=c:GetControler() or e:GetHandler():GetEquipTarget()==c
end
function c504700056.target(e,tp,eg,ep,ev,re,r,rp,tc,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,tc,1,0,0)
end
function c504700056.damcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
			and not e:GetHandler():GetEquipTarget():IsImmuneToEffect(e)
end
function c504700056.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,800)
end
function c504700056.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c504700056.desfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x45)
end
function c504700056.descon(e)
	return not Duel.IsExistingMatchingCard(c504700056.desfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
function c504700056.ctval(e,c)
	return e:GetHandlerPlayer()
end