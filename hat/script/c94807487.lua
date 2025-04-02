--ホープ剣スラッシュ
--Rising Sun Slash
function c94807487.initial_effect(c)
	c:EnableCounterPermit(0x31)
	aux.AddEquipProcedure(c,nil,aux.FilterBoolFunction(Card.IsSetCard,0x107f))
	--Untargetable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--counter
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_COUNTER)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_ATTACK_DISABLED)
	e4:SetRange(LOCATION_SZONE)
	e4:SetOperation(c94807487.regop)
	c:RegisterEffect(e4)
	--atk
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetValue(c94807487.value)
	c:RegisterEffect(e5)
	--remove overlay replace
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringc94807487(c94807487,0))
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_OVERLAY_REMOVE_REPLACE)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCondition(c94807487.rcon)
	e6:SetOperation(c94807487.rop)
	c:RegisterEffect(e6)
end
c94807487.listed_series={0x107f}
c94807487.counter_place_list={0x31}
function c94807487.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x31,1)
end
function c94807487.value(e,c)
	return e:GetHandler():GetCounter(0x31)*500
end
function c94807487.rcon(e,tp,eg,ep,ev,re,r,rp)
	return (r&REASON_COST)~=0 and re:GetHandler():IsType(TYPE_XYZ)
		and ep==e:GetOwnerPlayer() and e:GetHandler():GetEquipTarget()==re:GetHandler() and re:GetHandler():GetOverlayCount()>=ev-1
end
function c94807487.rop(e,tp,eg,ep,ev,re,r,rp)
	return Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end