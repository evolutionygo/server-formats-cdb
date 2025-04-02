--ナイトメアを駆る死霊
--Reaper on the Nightmare
function c85684223.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,23205979,59290628)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--handes
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc85684223(c85684223,0))
	e2:SetCategory(CATEGORY_HANDES)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c85684223.condition)
	e2:SetTarget(c85684223.target)
	e2:SetOperation(c85684223.operation)
	c:RegisterEffect(e2)
	--self des
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c85684223.sdcon)
	c:RegisterEffect(e3)
	--be target
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_CHAIN_SOLVED)
	e4:SetOperation(c85684223.desop1)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_BATTLED)
	e5:SetOperation(c85684223.desop2)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetCode(EVENT_BECOME_TARGET)
	e6:SetOperation(c85684223.register)
	c:RegisterEffect(e6)
	--direct attack
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e7)
end
function c85684223.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetAttackTarget()==nil
end
function c85684223.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,0,0,1-tp,1)
end
function c85684223.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(ep,LOCATION_HAND,0)
	if #g==0 then return end
	local sg=g:RandomSelect(1-tp,1)
	Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
end
function c85684223.sdcon(e)
	return e:GetHandler():GetOwnerTargetCount()>0
end
function c85684223.register(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(c85684223+1,RESET_CHAIN,0,1,ev)
end
function c85684223.desop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or not g:IsContains(c) then return false end
	for _,ch in ipairs({c:GetFlagEffectLabel(c85684223+1)}) do
		if ch==ev then
			if (Duel.GetCurrentPhase()&(PHASE_DAMAGE|PHASE_DAMAGE_CAL))~=0 and not Duel.IsDamageCalculated() then
				c:RegisterFlagEffect(c85684223,RESET_PHASE|PHASE_DAMAGE|RESETS_STANDARD,0,1)
			elseif not c:IsHasEffect(EFFECT_DISABLE) and not c:IsDisabled() then
				Duel.Destroy(c,REASON_EFFECT)
			end
			return
		end
	end
end
function c85684223.desop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(c85684223)>0 and not c:IsHasEffect(EFFECT_DISABLE) and not c:IsDisabled() then
		Duel.Destroy(c,REASON_EFFECT)
	end
end