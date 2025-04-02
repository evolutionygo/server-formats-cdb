--死のデッキ破壊ウイルス (Anime)
--Crush Card Virus (Anime)
--Updated by Larry126
function c513000009.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c513000009.target)
	e1:SetOperation(c513000009.activate)
	c:RegisterEffect(e1)
end
function c513000009.filter(c)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsAttackBelow(1000) and c:IsFaceup()
end
function c513000009.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c513000009.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c513000009.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SelectTarget(tp,c513000009.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c513000009.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		--Virus
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_DESTROYED)
		e1:SetCountLimit(1)
		e1:SetLabelObject(tc)
		e1:SetCondition(c513000009.descon)
		e1:SetOperation(c513000009.desop)
		Duel.RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetCode(EVENT_DESTROY)
		e2:SetLabelObject(e1)
		e2:SetOperation(c513000009.checkop)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2,true)
	end
end
function c513000009.checkop(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(1)
end
function c513000009.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetLabelObject()
	return e:GetLabel()==1 and c:GetPreviousAttributeOnField()&ATTRIBUTE_DARK==ATTRIBUTE_DARK
		and c:GetPreviousAttackOnField()<=1000 and c:GetPreviousControler()==tp
end
function c513000009.desfilter(c)
	return c:IsMonster() and c:IsAttackAbove(1500)
end
function c513000009.desop(e,tp,eg,ep,ev,re,r,rp)
	local conf=Duel.GetFieldGroup(tp,0,LOCATION_MZONE+LOCATION_HAND+LOCATION_DECK)
	if #conf>0 then
		Duel.ConfirmCards(tp,conf)
		local dg=conf:Filter(c513000009.desfilter,nil)
		Duel.Destroy(dg,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	end
	e:SetLabel(0)
	e:Reset()
end