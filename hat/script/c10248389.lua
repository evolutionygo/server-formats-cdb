--サイバー・ブレイダー
--Cyber Blader
function c10248389.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,false,false,97023549,11460577)
	--Cannot be destroyed by battle
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetCondition(c10248389.con)
	e1:SetLabel(1)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Increase ATK
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SET_ATTACK_FINAL)
	e2:SetLabel(2)
	e2:SetCondition(c10248389.con)
	e2:SetValue(c10248389.atkval)
	c:RegisterEffect(e2)
	--negate effects
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetLabel(3)
	e3:SetCondition(c10248389.con)
	e3:SetOperation(c10248389.disop)
	c:RegisterEffect(e3)
	aux.DoubleSnareValc10248389ity(c,LOCATION_MZONE)
end
c10248389.material_setcode=0x93
function c10248389.con(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)==e:GetLabel()
end
function c10248389.atkval(e,c)
	return c:GetAttack()*2
end
function c10248389.disop(e,tp,eg,ep,ev,re,r,rp)
	if rp~=tp then
		Duel.NegateEffect(ev)
	end
end