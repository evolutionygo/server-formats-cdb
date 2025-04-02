--属性重力－アトリビュート・グラビティ (Anime)
--Attribute Gravity (Anime)
--Scripted by Keddy
--Rescripted by Larry126
function c513000128.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Must attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_MUST_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c513000128.atktg)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_MUST_ATTACK_MONSTER)
	e3:SetValue(c513000128.atkval)
	c:RegisterEffect(e3)
end
function c513000128.atktg(e,c)
	e:SetLabel(c:GetAttribute())
	return c:IsAttackPos() and Duel.IsExistingMatchingCard(c513000128.adval,c:GetControler(),0,LOCATION_MZONE,1,nil,c:GetAttribute())
end
function c513000128.adval(c,att)
	return c:IsFaceup() and c:IsAttribute(att)
end
function c513000128.atkval(e,c)
	return c:IsAttribute(e:GetLabel())
end