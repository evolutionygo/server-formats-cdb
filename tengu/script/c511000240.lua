--エクゾディア・ネクロス(Anime)
--Exodia Necross (Anime)
function c511000240.initial_effect(c)
	c:EnableReviveLimit()
	--"Exodia the Forbc511000240den One": This card cannot be destroyed by battle
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511000240.battlecon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--"Left Leg of the Forbc511000240den One": This card cannot be destroyed by Spell Cardc511000240.
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511000240.spellcon)
	e3:SetValue(c511000240.spellval)
	c:RegisterEffect(e3)
	--"Right Leg of the Forbc511000240den One": This card cannot be destroyed by Trap Cardc511000240.
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c511000240.trapcon)
	e4:SetValue(c511000240.trapval)
	c:RegisterEffect(e4)
	--"Left Arm of the Forbc511000240den One": This card cannot be destroyed by the effects of other Effect Monsterc511000240.
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c511000240.monstercon)
	e5:SetValue(c511000240.monsterval)
	c:RegisterEffect(e5)
	--"Right Arm of the Forbc511000240den One": Each time this card battles, it gains 1000 ATK at the end of the Damage Step.
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringc511000240(c511000240,0))
	e6:SetCategory(CATEGORY_ATKCHANGE)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_DAMAGE_STEP_END)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCondition(c511000240.atkcon)
	e6:SetOperation(c511000240.atkop)
	c:RegisterEffect(e6)
	--Revert ATK changes if removed from field/if no Right Arm in GY
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_UPDATE_ATTACK)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetValue(c511000240.atkval)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_MOVE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetOperation(c511000240.resetatk)
	c:RegisterEffect(e8)
end
c511000240.listed_names={33396948,44519536,8124921,7902349,70903634}
function c511000240.battlecon(e)
	return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,33396948)
end
function c511000240.spellcon(e)
	return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,44519536)
end
function c511000240.spellval(e,re,rp)
	return re:IsActiveType(TYPE_SPELL)
end
function c511000240.trapcon(e)
	return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,8124921)
end
function c511000240.trapval(e,re,rp)
	return re:IsActiveType(TYPE_TRAP)
end
function c511000240.monstercon(e)
	return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,7902349)
end
function c511000240.monsterval(e,re,rp)
	return re:IsActiveType(TYPE_MONSTER)
end
function c511000240.atkcon(e)
	return Duel.IsExistingMatchingCard(Card.IsCode,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,70903634)
end
function c511000240.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		c:RegisterFlagEffect(c511000240,RESET_EVENT+RESETS_STANDARD_DISABLE,0,1)
	end
end
function c511000240.atkval(e,c)
	return e:GetHandler():GetFlagEffect(c511000240)*1000
end
function c511000240.resetatk(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,70903634) then return end
	local c=e:GetHandler()
	if c:GetFlagEffect(c511000240)>0 then
		c:ResetFlagEffect(c511000240)
	end
end