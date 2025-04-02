--ブルーアイズ・トゥーン・ドラゴン
--Blue-Eyes Toon Dragon
function c53183600.initial_effect(c)
	c:EnableReviveLimit()
	--Special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c53183600.spcon)
	e1:SetTarget(c53183600.sptg)
	e1:SetOperation(c53183600.spop)
	c:RegisterEffect(e1)
	--Destroy itself
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c53183600.sdescon)
	e2:SetOperation(c53183600.sdesop)
	c:RegisterEffect(e2)
	--Direct attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	e3:SetCondition(c53183600.dircon)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e4:SetCondition(c53183600.atcon)
	e4:SetValue(c53183600.atlimit)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e5:SetCondition(c53183600.atcon)
	c:RegisterEffect(e5)
	--Cannot attack
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_SPSUMMON_SUCCESS)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetOperation(c53183600.atklimit)
	c:RegisterEffect(e6)
	--Attack cost
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_ATTACK_COST)
	e7:SetCost(c53183600.atcost)
	e7:SetOperation(c53183600.atop)
	c:RegisterEffect(e7)
end
c53183600.listed_names={15259703}
function c53183600.spcon(e,c)
	if c==nil then return true end
	return Duel.CheckReleaseGroup(c:GetControler(),aux.TRUE,2,false,2,true,c,c:GetControler(),nil,false,nil)
		and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,15259703),c:GetControler(),LOCATION_ONFIELD,0,1,nil)
end
function c53183600.sptg(e,tp,eg,ep,ev,re,r,rp,c)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.SelectReleaseGroup(tp,aux.TRUE,2,2,false,true,true,c,nil,nil,false,nil)
	if g then
		g:KeepAlive()
		e:SetLabelObject(g)
	return true
	end
	return false
end
function c53183600.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	if not g then return end
	Duel.Release(g,REASON_COST)
	g:DeleteGroup()
end
function c53183600.sfilter(c)
	return c:IsReason(REASON_DESTROY) and c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==15259703 and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c53183600.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c53183600.sfilter,1,nil)
end
function c53183600.sdesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c53183600.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c53183600.dircon(e)
	return not Duel.IsExistingMatchingCard(c53183600.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c53183600.atcon(e)
	return Duel.IsExistingMatchingCard(c53183600.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c53183600.atlimit(e,c)
	return not c:IsType(TYPE_TOON) or c:IsFacedown()
end
function c53183600.atklimit(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c53183600.atcost(e,c,tp)
	return Duel.CheckLPCost(tp,500)
end
function c53183600.atop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsAttackCostPac53183600()~=2 and e:GetHandler():IsLocation(LOCATION_MZONE) then
		Duel.PayLPCost(tp,500)
		Duel.AttackCostPac53183600()
	end
end