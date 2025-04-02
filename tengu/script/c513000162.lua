--眠れる巨人ズシン (Anime)
--Zushin the Sleeping Giant (Anime)
--Scripted by Larry126
function c513000162.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c513000162.spcon3)
	e2:SetOperation(c513000162.spop3)
	c:RegisterEffect(e2)
	--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SET_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(function(e) return e:GetHandler():GetBattleTarget() end)
	e3:SetValue(c513000162.atkval)
	c:RegisterEffect(e3)
	--negate
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_DISABLE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetTarget(c513000162.distg)
	c:RegisterEffect(e4)
	--cannot be target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(1)
	c:RegisterEffect(e5)
	aux.GlobalCheck(s,function()
		--spsummon proc
		local e2=Effect.CreateEffect(c)
		e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetCountLimit(1)
		e2:SetOperation(c513000162.spop)
		Duel.RegisterEffect(e2,0)
	end)
end
function c513000162.spfilter1(c)
	return c:IsFaceup() and c:GetLevel()==1 and c:IsType(TYPE_NORMAL)
end
function c513000162.spop(e,tp,c)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c513000162.spfilter1,Duel.GetTurnPlayer(),LOCATION_MZONE,0,nil)
	local rc=g:GetFirst()
	while rc do
		if rc:GetFlagEffect(c513000162)==0 then
			local e1=Effect.CreateEffect(rc)
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PHASE_START+PHASE_STANDBY)
			e1:SetCountLimit(1)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCondition(c513000162.spcon1)
			e1:SetLabel(0)
			e1:SetOperation(c513000162.spop2)
			rc:RegisterEffect(e1)
			rc:RegisterFlagEffect(c513000162,RESET_EVENT|RESETS_STANDARD,0,1)
		end
		rc=g:GetNext()
	end
end
function c513000162.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c513000162.spop2(e,tp,c)
	local c=e:GetHandler()
	if c:GetControler()~=Duel.GetTurnPlayer() then return end
	local ct=e:GetLabel()
	if c:GetFlagEffect(c513000162)~=0 and ct==8 then
		c:RegisterFlagEffect(100000111,RESET_EVENT|RESETS_STANDARD,0,1)
	else
		e:SetLabel(ct+1)
	end
end
function c513000162.filter(c)
	return c:IsFaceup() and c:GetLevel()==1 and c:IsType(TYPE_NORMAL) and c:GetFlagEffect(100000111)~=0
end
function c513000162.spcon3(e,c)
	local c=e:GetHandler()
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.CheckReleaseGroup(c:GetControler(),c513000162.filter,1,nil)
end
function c513000162.spop3(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(tp,c513000162.filter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c513000162.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c513000162.atkval(e,c)
	local bc=c:GetBattleTarget()
	return bc:IsHasEffect(21208154) and bc:IsAttack(0) and c:GetAttack() or bc:GetAttack()+1000
end
function c513000162.distg(e,c)
	return e:GetHandler():GetBattleTarget()==c
end